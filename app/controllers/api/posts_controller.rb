class Api::PostsController < Api::ApiController
  ALLOWED_SORT_FILEDS = ["id", "reads", "likes", "popularity"].freeze
  ALLOWED_DIRECTIONS = ["desc", "asc"].freeze

  def index
    return render(json: {"error": "tags parameter is required" }, status: 400) unless posts_params[:tags].present? 

    tags = JSON.parse(posts_params[:tags].to_json).split(',')

    result = tags.each_with_object({}) do |tag, result|
      th = Thread.new do
        byebug
        fetch_posts(tag).each do |key, value| # {"posts": [{"id": 1}]}
          if result[key].nil?
            result[key] = value
          else
            result[key].push(*value)
          end
        end
      end
      th.join
    end

    # Remove duplicate enteries
    result[result.keys[0]].uniq! { |entry| entry["id"] }

    # sort based on sortBy params
    if ALLOWED_SORT_FILEDS.include?(posts_params[:sortBy])
      if ALLOWED_DIRECTIONS.include?(posts_params[:direction])
        if posts_params[:direction] == "desc"
          result[result.keys[0]].sort_by! { |entry| entry[posts_params[:sortBy]] }
          result[result.keys[0]].reverse!
        else
          result[result.keys[0]].sort_by! { |entry| entry[posts_params[:sortBy]] }
        end
      end
    else
      return render json: { "error": "sortBy parameter is invalid" }, status: 400
    end
    render json: result, status: 200
  end

  private
  def fetch_posts(tag)
    begin
      data_uri = uri(tag: tag)
      res = RestClient.get(data_uri)
      
      if res.code == 200
        return JSON.parse(res.body)
      else
        res = {
          "posts": nil,
          "error": true,
        }
        return res
      end
    rescue RestClient::BadRequest => err
      return JSON.parse(err.response)
    end
  end

  def uri(tag:)
    "https://api.hatchways.io/assessment/blog/posts?tag=#{tag}"
  end

  def posts_params
    posts_params = params.permit(:tags, :sortBy, :direction)
    posts_params.merge!(sortBy: "id") unless posts_params[:sortBy].present?
    posts_params.merge!(direction: "asc") unless posts_params[:direction].present?
    posts_params
  end
end
