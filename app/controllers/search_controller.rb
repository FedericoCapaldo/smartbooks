class SearchController < ApplicationController

  def index
  end

  def result
    if params[:title] == "" && params[:author] == ""
      redirect_to '/'
    else

      final_url = gen_url(params[:title], params[:author])
      response = make_solr_request(final_url)
      jsonResponse = JSON.parse(response)

      @documents = jsonResponse["response"]["docs"]
    end
  end

  private
    def gen_url(titleParam, authorParam)
      base_url = "http://ec2-52-40-24-42.us-west-2.compute.amazonaws.com:8983/solr/TEXTBOOK_DB/select?indent=on&q="
      wildcard = "\""
      title = titleParam.strip
      author = authorParam.strip
      json_format_r = "&wt=json"

      titleQuery = "title:" + wildcard + title + wildcard
      authorQuery = "author:" + wildcard + author + wildcard
      final_url = base_url + (title.empty? ? "" : titleQuery ) + ((!title.empty? && !author.empty?) ? " AND " : "") + (author.empty? ? "" : authorQuery) + json_format_r

      final_url
    end

    def make_solr_request(url)
      uri = URI.parse(url)
      response = Net::HTTP.get(uri)
      response
    end

end
