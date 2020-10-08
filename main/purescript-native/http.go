package ffi_loader

import (
	. "github.com/purescript-native/go-runtime"
	"io/ioutil"
	"net/http"
)

func init() {
	exports := Foreign("Http")

	// https://golangcode.com/get-the-http-response-status-code/
	exports["httpGet'"] = func(left Any) Any {
		return func(right Any) Any {
			return func(url_ Any) Any {
				return func() Any {
					url := url_.(string)
					resp, err := http.Get(url)
					if err == nil {
						return Apply(right, resp)
					} else {
						return Apply(left, err.Error())
					}
				}
			}
		}
	}

	// TODO: I think this should only ever be called on the body once
	// should it return an effect?
	exports["httpBody'"] = func(left Any) Any {
		return func(right Any) Any {
			return func(response_ Any) Any {
				return func() Any {
					response := response_.(*http.Response)
					defer response.Body.Close()
					body, err := ioutil.ReadAll(response.Body)
					if err == nil {
						return Apply(right, string(body))
					} else {
						return Apply(left, err.Error())
					}
				}
			}
		}
	}
}
