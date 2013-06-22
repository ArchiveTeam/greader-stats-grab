wget.callbacks.httploop_result = function(url, err, http_stat)
  code = http_stat.statcode
  if not (code == 200) then
    -- Long delay because people like to run with way too much concurrency
    delay = 1200

    io.stdout:write("\nServer returned status "..code.."; this is probably a CAPTCHA page.\n")
    io.stdout:write("You may want to move to another IP.  Waiting for "..delay.." seconds and exiting...\n")
    io.stdout:flush()

    os.execute("sleep "..delay)
    -- We have to give up on this WARC; we don't want to upload anything with
    -- error responses to the upload target
    return wget.actions.ABORT

  else
    return wget.actions.NOTHING
  end
end
