module vwebview

#flag -I @VROOT/headers
#flag -I C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0
#flag -I C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\winrt
#flag -L .
#flag windows -lwebview
#flag windows -lWebView2Loader

$if linux {
	#pkgconfig gtk+-3.0
	#pkgconfig gdk-pixbuf-2.0
	#pkgconfig webkit2gtk-4.0
}

//#flag -DWEBVIEW_HEADER
#include "webview.h"

[noinit]
pub struct Webview {
mut:
	ptr       voidptr
	running   bool
}

// WebviewSizeHint specifies how to use the sizes passed by WebviewConfig
// default - Width and height are default size
// min     - Width and height are minimum bounds
// max     - Width and height are maximum bounds
// fixed   - Window size cannot be changed by the user
pub enum WebviewSizeHint {
	default
	min
	max
	fixed
}

// WebviewConfig is used to set the default values for a new `Webview`
pub struct WebviewConfig {
	debug       bool
	height      int             = 600
	size_hint   WebviewSizeHint
	title       string
	url         string
	width       int             = 800
	window_ptr  voidptr
}

// new takes in a config and initializes a new webview with the provided settings
pub fn new(config WebviewConfig) ?Webview {
	webview := Webview{ ptr: C.webview_create(if config.debug { 1 } else { 0 }, config.window_ptr) }
	
	if webview.ptr == 0 {
		return error("Unable to initialize webview")
	}

	webview.navigate(config.url)
	webview.set_size(config.width, config.height, config.size_hint)
	webview.set_title(config.title)

	return webview
}

pub fn (mut webview Webview) free() {
	if webview.ptr == 0 {
		return
	}

	C.webview_destroy(webview.ptr)
	C.free(webview.ptr)
	webview.ptr = voidptr(0)
}

pub fn (webview Webview) navigate(url string) {
	C.webview_navigate(webview.ptr, url.str)
}

pub fn (webview Webview) run() {
	C.webview_run(webview.ptr)
}

pub fn (webview Webview) set_size(width int, height int, hints WebviewSizeHint) {
	C.webview_set_size(webview.ptr, width, height, hints)
}

pub fn (webview Webview) set_title(title string) {
	C.webview_set_title(webview.ptr, title.str)
}

pub fn (webview Webview) terminate() {
	C.webview_terminate(webview.ptr)
}