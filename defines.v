module vwebview

type DispatchFn = fn(voidptr, voidptr)
type BindFn = fn(charptr, charptr, voidptr) voidptr

fn C.webview_create(int, voidptr) voidptr

fn C.webview_destroy(voidptr)

fn C.webview_run(voidptr)

fn C.webview_terminate(voidptr)

fn C.webview_dispatch(voidptr, DispatchFn, voidptr)

fn C.webview_get_window(voidptr) voidptr

fn C.webview_set_title(voidptr, charptr)

fn C.webview_set_size(voidptr, int, int, int)

fn C.webview_navigate(voidptr, charptr)

fn C.webview_init(voidptr, charptr)

fn C.webview_eval(voidptr, charptr)

fn C.webview_bind(voidptr, charptr, BindFn, voidptr)

fn C.webview_return(voidptr, charptr, int, charptr)