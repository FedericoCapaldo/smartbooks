class SearchController < ApplicationController
  #consider to add try and catch for methods that make requests
  def index
    @subjects = prepare_subjects
  end

  def result
    @subjects = prepare_subjects

    if params[:type] == "free"
      if params[:title] == "" && params[:author] == "" && params[:subject] == ""
        flash[:danger] = "Empty search not allowed."
        redirect_to root_path
      else
        final_url = gen_url(params[:title], params[:author], params[:subject])
        response = solr_request(final_url)
        jsonResponse = JSON.parse(response)
        @documents = jsonResponse["response"]["docs"] unless jsonResponse["response"]["docs"].count == 0
      end
    elsif params[:type] == "paid"
        ads_by_title = Advertisement.where("title like ? OR content like ?", "%#{params[:title]}%", "%#{params[:title]}%") unless params[:title] == ""

        ads_by_author = Advertisement.where("title like ? OR content like ? ", "%#{params[:author]}%", "%#{params[:author]}%") unless params[:author] == "" || params[:author] == params[:title]

        if ads_by_title && ads_by_author
          @ads = ads_by_title + ads_by_author
        elsif ads_by_author && !ads_by_title
          @ads = ads_by_author
        elsif ads_by_title && !ads_by_author
          @ads = ads_by_title
        end
    end
  end

  private
    def gen_url(titleParam, authorParam, subjectParam)
      base_url = "http://ec2-52-40-24-42.us-west-2.compute.amazonaws.com:8983/solr/TEXTBOOK_DB/select?indent=on&q="
      wildcard = "\""
      title = titleParam.strip
      author = authorParam.strip
      subject = subjectParam.strip
      json_format_r = "&wt=json"

      titleQuery = "title:" + wildcard + title + wildcard
      authorQuery = "author:" + wildcard + author + wildcard
      subjectQuery = "subject:" + wildcard + subject + wildcard

      final_url = base_url + (title.empty? ? "" : titleQuery ) +
                  ((!title.empty? && !author.empty?) ? " AND " : "") + (author.empty? ? "" : authorQuery) +
                  ((!author.empty? && !subject.empty?) ? " AND " : "") + (subject.empty? ? "" : subjectQuery) +
                  json_format_r
      final_url
    end

    def solr_request(url)
      uri = URI.parse(url)
      response = Net::HTTP.get(uri)
      response
    end

    def get_solr_subjects
      url = "http://ec2-52-40-24-42.us-west-2.compute.amazonaws.com:8983/solr/TEXTBOOK_DB/select/?q=*%3A*&rows=0&facet=on&facet.field=subject_s&wt=json"
      response = solr_request(url)
      response
    end

    def prepare_subjects
      jsonSubjects = JSON.parse(get_solr_subjects)
      subjects = []
      jsonSubjects["facet_counts"]["facet_fields"]["subject_s"].each do |sub|
        subjects << sub.capitalize if sub.is_a? String
      end
      subjects
    end

end
