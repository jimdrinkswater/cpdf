prawn_document(:page_size => [ 392, 612], :margin => [ 37, 55, 37, 55]) do |p|

#p.font "Helvetica"
p.fill_color "000000"

#cover image

p.image Rails.root.join('app', 'assets', 'images', 'issues', "#{@issue.nice_count}.png"), :at => [-55, 575], :width => 392, :height => 612

p.font_families.update("Maison" => {
:normal => "#{Rails.root}/app/assets/fonts/maisonneuebook.ttf",
:italic => "#{Rails.root}/app/assets/fonts/maisonneuebookitalic.ttf",
:bold => "#{Rails.root}/app/assets/fonts/maisonneuebold.ttf",
:bold_italic => "#{Rails.root}/app/assets/fonts/maisonneuebolditalic.ttf",
:mono => "#{Rails.root}/app/assets/fonts/maisonneuemono.ttf",
:mono_italic => "#{Rails.root}/app/assets/fonts/maisonneuemonoitalic.ttf"

})

p.font "Maison"

#blank inside cover
p.start_new_page
  #opacity square
  p.transparent( (@issue.view_count%50).to_f/100) do
    p.rectangle [-55, 575], 392, 612
    p.fill
  end

#title page
p.start_new_page
p.fill_color "000000"
p.rectangle [-55, 575], 392, 612
p.fill


p.fill_color "ffffff"
p.font_size 12

p.move_down 10
p.draw_text "Book Book", :style => :bold, :at => [205, p.cursor], :leading => 2
p.move_down 20
p.draw_text "/", :style => :bold, :at => [230, p.cursor], :leading => 2
p.move_down 20
p.draw_text "Graphic Design", :style => :bold, :at => [205, p.cursor], :leading => 2
p.move_down 20
p.draw_text "/", :style => :bold, :at => [230, p.cursor], :leading => 2
p.move_down 20
p.draw_text "Reference Book", :style => :bold, :at => [205, p.cursor], :leading => 2


p.start_new_page

#TOC
p.fill_color "000000"
p.rectangle [-55, 575], 392, 612
p.fill

p.fill_color "ffffff"

p.font_size 7

page = 1
p.text "Contents", :style => :bold

p.move_down 5

@documents.each do | document |
  page = page + 1
  p.text page.to_s, :style => :mono

  p.move_down 2

  p.text document.title, :style => :bold, :leading => 2

  p.move_down 5

end

p.start_new_page

#about page
p.fill_color "000000"
p.rectangle [-55, 575], 392, 612
p.fill

p.fill_color "ffffff"
p.draw_text "Book Book • 1st Edition", :style => :bold, :at => [50, p.cursor], :leading => 2

p.move_down( p.cursor - 500 )

p.text_box "An up-to-date graphic design reference book. Each Issue acts as a snapshot of the booklets corresponding website. And is published in a limited edition of 50 copies through on-demand printers. As copies are printed, 1% black is added across the document. Once 50% black is reached, issue 2 is released for another 50 copies, and resets the cycle.", :at => [50, p.cursor], :leading => 2


#blank black page
p.start_new_page
p.fill_color "000000"
p.rectangle [-55, 575], 392, 612
p.fill

#blank black page
p.start_new_page
p.fill_color "000000"
p.rectangle [-55, 575], 392, 612
p.fill

p.fill_color "ffffff"
p.font_size 12

p.move_down 10
p.draw_text "16 References", :style => :bold, :at => [205, p.cursor], :leading => 2
p.move_down 20
p.draw_text "/", :style => :bold, :at => [230, p.cursor], :leading => 2
p.move_down 20
p.draw_text "Ordered", :style => :bold, :at => [205, p.cursor], :leading => 2
p.move_down 20
p.draw_text "/", :style => :bold, :at => [230, p.cursor], :leading => 2
p.move_down 20
p.draw_text "Alphabetically", :style => :bold, :at => [205, p.cursor], :leading => 2

#blank black page
p.start_new_page
p.fill_color "000000"
p.rectangle [-55, 575], 392, 612
p.fill

p.start_new_page

p.fill_color "000000"

#used
letter_count = 1

#for printing out the page number
page = 2
@documents.each_with_index do | document, index |
  page = page + 1

  #opacity square
  p.transparent( (@issue.view_count%50).to_f/100) do
    p.rectangle [-55, 575], 392, 612
    p.fill
  end

  #running side
  p.repeat(:odd) do
    p.font_size 6  
    p.draw_text "1st Edition, #{@issue.nice_count}/50",
    :at => [310,311],
    :width => 100,
    :rotate => 270,
    :style => :mono, 
    :rotate_around => :center
  end

  #page number
  p.font_size 6

  #format page number to stack
  formatted_page = "%02d" % page
  formatted_page = formatted_page[0] + "\n" + formatted_page[1]

  #decide if page number is odd of even
  if page%2 == 0
    #even
    page_num_x = -60
    page_num_y = 537
  else
    #odd
    page_num_x = 282
    page_num_y = 537
  end

  p.text_box formatted_page,
    :at => [page_num_x, page_num_y],
    :width => 59,
    :height => 50,
    :align => :center,
    :style => :mono  

  #line above big letter
  
  p.stroke_color "999999"

  p.line [0, 540], [88, 540]
  p.stroke
  
  p.move_down 2

  #big letter
  p.font_size 32
  p.draw_text document.title[0], :style => :mono, :at => [ -3, p.cursor + -24  ]

  #code for keeping track of little number next to letter
  if index != 0
    prev_letter = @documents[index -1].title[0]
    if prev_letter == document.title[0]
      letter_count += 1
    else
      letter_count = 1
    end
  end

  p.font_size 12
  #little number
  p.text_box letter_count.to_s,
   :at => [0, p.cursor + 0 ],
   :width => 28,
   :height => 50,
   :align => :right,
   :style => :mono,
   :leading => 2

  p.move_down 28

  #title
  p.font_size 12
  p.text document.title, :style => :bold

  y_position = p.cursor - 85


  #tag list
  p.font_size 5
  if document.tags
    p.text_box document.tags,
      :at => [0, y_position + -10],
      :width => 39,
      :align => :right,
      :rotate_around => :center,
      :leading => 3
  end


  # short line above text
  p.line [50, y_position+5], [60, y_position+5]
  p.stroke

  #category
  if document.category
    p.font_size 6
    p.text_box document.category,
       :at => [50, y_position],
       :width => 238,
       :height => 10,
       :align => :left,
       :style => :bold,
       :character_spacing => 0.5
  end
  #body
  p.font_size 7
  if document.body
    p.text_box document.body,
       :at => [50, y_position + -10],
       :leading => 2,
       :width => 238,
       :height => 300,
       :align => :left
  end

  #image
  p.move_down( y_position - 116 )
  if document.image_name and !document.image_name.empty?
    p.image Rails.root.join('app', 'assets', 'images', 'documents', document.image_name), :fit => [288, 176]
  end


    if index != ( @documents.length - 1)
      p.start_new_page
    end
  

  end

  p.start_new_page
  #opacity square
  p.transparent( (@issue.view_count%50).to_f/100) do
    p.rectangle [-55, 575], 392, 612
    p.fill
  end

  p.start_new_page
  #opacity square
  p.transparent( (@issue.view_count%50).to_f/100) do
    p.rectangle [-55, 575], 392, 612
    p.fill
  end

  p.text_box "Designed and developed under the guidance of Leonardo Sonnoli, RISD Winter Session 2013. With programming assistance by Daniel Pennypacker. Typeset in Maison Neue by MilieuGrotesque, printed by Peecho.", :at => [0, 40], :leading => 2

  p.start_new_page
  #opacity square
  p.transparent( (@issue.view_count%50).to_f/100) do
    p.rectangle [-55, 575], 392, 612
    p.fill
  end 

end