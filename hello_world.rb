require 'glim_ai'
glim = GlimContext.new
req = glim.request(llm_name: "gpt-3.5-turbo")
req.prompt = "Who came up with the phrase 'Hello World?'"
puts req.response.completion
puts "Cost = $ #{req.response.total_cost}"