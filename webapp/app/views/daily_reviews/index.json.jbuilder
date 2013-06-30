json.array!(@reviews) do |review|
  json.extract! review, :id, :date, :done
  json.title( review.done? ? "DONE" : "?" )
  json.url "/"
  json.start review.date
  json.end review.date
end
