module main

import vwebview

pub fn main() {
	webview := vwebview.new({ title: "Vlang.io", url: "https://www.vlang.io" }) ?
	webview.run ()
}