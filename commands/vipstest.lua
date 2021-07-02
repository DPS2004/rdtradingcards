local command = {}
function command.run(message, mt)
  -- vips.log.enable(true)
  local image1 = vips.Image.text(mt[1], { dpi = 300 })
  image1:write_to_file("vips_out/vipstest.png")
  message.channel:send{
    content = "imag e procecsinng",
    file = "vips_out/vipstest.png"
  }
  print(message.author.name .. " did !vipstest")
end
return command
