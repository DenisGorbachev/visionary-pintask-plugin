insertLink = ($listHeaderQuickIcons) ->
  $link = $("<div class='expand-collapse-all-cards icon-list' title='Expand or collapse all cards in this list'></div>")
  $link.on("click", clickListener)
  $listHeaderQuickIcons.prepend($link)

clickListener = (event) ->
  listId = $(event.target).closest(".board-list").attr("data-id")
  firstCard = Cards.findOne({listId: listId}, {sort: {position: 1}})
  if !firstCard
    return
  shouldOpen = !Session.get(firstCard.htmlId() + "-is-open")
  Cards.find({listId: listId}).forEach (card) ->
    Session.set(card.htmlId() + "-is-open", shouldOpen)

Template.listHeader.rendered = _.compose(->
  insertLink($(@find(".board-list-header .quick-icons")))
, Template.listHeader.rendered)

Meteor.startup ->
  insertLink($(".board-list-header .quick-icons"))
