local command = {}
function command.run(message, mt)
  message.channel:send {
      content = "Hello world!", -- Content besides the button is required. This content can be text, embeds, files, etc.
      components = {
          {
              type = 1,
              components = {
                  {
                      type = 2,
                      style = 1,
                      label = "Test Button",
                      custom_id = "test_button",
                      disabled = false
                  }
              }
          }
      }
  }
  print(message.author.name .. " did !buttontest")
end
return command
  