window.app = angular.module("sparta",['rails'])

app.config([
  '$httpProvider'
  ($httpProvider) ->
    authToken = $("meta[name=\"csrf-token\"]").attr("content")
    $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
])
