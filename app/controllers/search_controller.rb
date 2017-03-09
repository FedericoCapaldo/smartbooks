class SearchController < ApplicationController

  def index
  end

  def result
    if params[:title] == "" && params[:author] == ""
      redirect_to '/'
    else
      base_url = "http://ec2-52-40-24-42.us-west-2.compute.amazonaws.com:8983/solr/TEXTBOOK_DB/select?indent=on&q="
      wildcard = "*"
      title = params[:title].strip.gsub(/\s+/, "\\ ")
      author = params[:author].strip.gsub(/\s+/, "\\ ")
      json_format_r = "&wt=json"

      titleQuery = "title:" + wildcard + title + wildcard
      authorQuery = "author:" + wildcard + author + wildcard
      final_url = base_url + (title.empty? ? "" : titleQuery ) + ((!title.empty? && !author.empty?) ? " AND " : "") + (author.empty? ? "" : authorQuery) + json_format_r

      uri = URI.parse(final_url)
      response = Net::HTTP.get(uri)

      jsonResponse = JSON.parse(response)

      @documents = jsonResponse["response"]["docs"]
    end
  end
end
