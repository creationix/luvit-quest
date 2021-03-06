
return function (req, res)
  local name = "tcp-client"

  res.body = res.body
    :gsub("%%HOST", req.socket:getsockname().ip)
    :gsub("%%PORT", req.socket:getsockname().port)
    :gsub("%%HASH", res.keygen(name))
    :gsub("%%NAME", name)
    :gsub("<!%-%-fields%-%->", [[
    <script>
      window.onload = function () {
        var xhr = new XMLHttpRequest();
        xhr.onload = function (e) {
          console.log(xhr);
          if (xhr.status === 200) {
            window.location = xhr.responseText;
          }
          else {
            throw xhr.responseText;
          }
        }
        xhr.open("GET", "/]] .. name .. [[/push")
        xhr.send()
      };
    </script>
  ]])

end
