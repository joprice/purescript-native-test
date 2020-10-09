package ffi_loader

// Load PureScript standard library FFI packages. Comment out the ones you don't need for
// faster/smaller builds.

import (
	_ "github.com/purescript-native/go-ffi/purescript-arrays"
	_ "github.com/purescript-native/go-ffi/purescript-effect"
	_ "github.com/purescript-native/go-ffi/purescript-foldable-traversable"
	_ "github.com/purescript-native/go-ffi/purescript-globals"
	_ "github.com/purescript-native/go-ffi/purescript-integers"
	_ "github.com/purescript-native/go-ffi/purescript-lazy"
	_ "github.com/purescript-native/go-ffi/purescript-math"
	_ "github.com/purescript-native/go-ffi/purescript-prelude"
	_ "github.com/purescript-native/go-ffi/purescript-strings"
	// TODO: remove this one by not using deps that rely on node
	_ "github.com/purescript-native/go-ffi/purescript-console"
	_ "github.com/purescript-native/go-ffi/purescript-unsafe-coerce"
	/*
		_ "github.com/purescript-native/go-ffi/purescript-random"
		_ "github.com/purescript-native/go-ffi/purescript-unfoldable"
	*/
	// for Foreign value '_indexOf' for purescript module 'Data.String.CodeUnits' not found
	//	_ "github.com/purescript-native/go-ffi/purescript-assert"
	//	_ "github.com/purescript-native/go-ffi/purescript-enums"
	//	_ "github.com/purescript-native/go-ffi/purescript-exceptions"
	//	_ "github.com/purescript-native/go-ffi/purescript-functions"
	//	_ "github.com/purescript-native/go-ffi/purescript-partial"
	//	_ "github.com/purescript-native/go-ffi/purescript-refs"
	//	_ "github.com/purescript-native/go-ffi/purescript-st"
	. "github.com/purescript-native/go-runtime"
	"os"
)

func init() {
	exports := Foreign("Main")
	exports["argv"] = func() Any {
		var args []interface{} = make([]interface{}, len(os.Args))
		for i, d := range os.Args {
			args[i] = d
		}
		return args
	}

	exports["exit"] = func(status_ Any) Any {
		status, _ := status_.(int)
		os.Exit(status)
		return nil
	}
}
