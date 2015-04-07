
return function (req, res)
  local ip = '"' .. req.socket:getsockname().ip .. '"'
  local port = req.socket:getsockname().port
  local hash = res.keygen("tcp-client")
  local line = '"GET /tcp-client/' .. hash .. ' HTTP/1.0\\r\\n\\r\\n"'

  res.body = res.body
    :gsub("%%LINE", line)
    :gsub("%%HOST", ip)
    :gsub("%%PORT", port)
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
        xhr.open("GET", "/tcp-client/push")
        xhr.send()
      };
    </script>
  ]])

end
