
#Cards seed
cards = {question: "What is the color of the sky?", :answer => "blue"}
Card.create(cards)
cards = {question: "What is 1 + 1?", :answer => "2"}
Card.create(cards)
cards = {question: "What is the capital of Romania?", :answer => "Bucharest"}
Card.create(cards)
Deck.create(:title => 'random', :cards => Card.all)

card1 = {question: "In what month is the longest day in the northern hemisphere?", :answer => "June"}
card2 = {question: "What do pandas eat?", :answer => "bamboo"}
card3 = {question: "Cynophobia is the fear of what kind of animal?", :answer => "dogs"}
cards = [card1, card2, card3]
cards.map! { |card| Card.create(card) }
Deck.create(:title => 'Trivia', :cards => cards )

