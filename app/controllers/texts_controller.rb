require 'uri'
require 'net/http'
require 'openssl'
require'json'

class TextsController < ApplicationController
  @@parsed_texts = []

  def index
  end

  def rewrite_text
    input = params[:paraphrase][:text]
    input.lstrip!
    input.gsub!("\r\n\r\n", "")
    paraphrased_text = api_call(input)
    @@parsed_texts << paraphrased_text
    redirect_to texts_path, notice: "Text Successfully Added"
  end

  def show_texts
    @texts = @@parsed_texts
  end

  def delete_texts
    @@parsed_texts.clear
    redirect_to texts_path, notice: "Texts Successfully Deleted"
  end

  private

  def api_call(text)
    url = URI("https://rewriter-paraphraser-text-changer-multi-language.p.rapidapi.com/rewrite")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request["x-rapidapi-key"] = '0ff14fe9e7msh77b3e0c40e4e814p1d4094jsn1d9333d48168'
    request["x-rapidapi-host"] = 'rewriter-paraphraser-text-changer-multi-language.p.rapidapi.com'
    request.body = "{
        \"language\": \"en\",
        \"strength\": 3,
        \"text\": \"#{text}\"
    }"
    response = http.request(request)
    parsed = JSON.parse(response.body)
  return parsed["rewrite"]
  end
end
