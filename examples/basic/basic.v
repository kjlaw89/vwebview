module main

import vwebview

pub fn main() {
	webview := vwebview.new({
		debug: true
		title: "Internet Search"
		url: "https://www.duckduckgo.com" 
	}) ?
	
	webview.run ()
}