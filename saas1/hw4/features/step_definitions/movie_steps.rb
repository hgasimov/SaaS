# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |movie, director|
  m = Movie.find_by_title(movie)
  assert m[:director] == director
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(",").each do |field|
    uncheck ? "When I uncheck #{field}" : "When I check #{field}"
  end
end

When /I check all ratings/ do
  ['R', 'G', 'PG', 'PG-13'].each do |rating|
    "When I check #{rating}"
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  # Movie.all.each { |movie| "Then I should see #{movie[:name]}" }
  assert(Movie.find(:all).length == page.body.scan(/<tr>/).length - 1, "Wrong number of movies are displayed") # head row isn't counted
end

Then /I should see movies sorted by (.*)/ do |field|
  assert(field == "name" || field == "release date")

  def strip_tag(s, lefts, rights)
    left = s.index(lefts);
    right = s.index(rights);
    if left != nil and right != nil
          found = s[left+4..right-1]
          return [found, s[right+5..-1]]
    else
          return [nil, s]
    end
  end

  def find_tag(s, lefts, rights)
    tags = []
    row, newstr = strip_tag(s, lefts, rights)
    while row!= nil do
          tags << row
          row, newstr = strip_tag(newstr, lefts, rights)
    end
    return tags
  end

  rows = find_tag(page.body, "<tr>", "</tr>")[1..-1] # ignore the header
  if rows.length > 1
      compare_id = field == "name" ? 0:2
      compare_to = find_tag(rows[0], "<td>", "</td>")[compare_id]

      rows[1..-1].each do |row|
          compare = find_tag(row, "<td>", "</td>")[compare_id]
          assert compare > compare_to, "Wrong order by #{field}"
          compare_to = compare
      end
  end
end

Then /I should see "(.*)" before "(.*)"/ do |movie1, movie2|
    assert page.body.scan(/"#{movie1}"(.*)"#{movie2}"/).length > 0
end
