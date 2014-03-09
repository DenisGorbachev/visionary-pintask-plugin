Visionary plugin for Pintask
=========================

Expand or collapse all cards in a list on [Pintask](http://pintask.me/), the hackable task tracker.

This versatile plugin is only a couple lines of code:

```coffee
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
```

_This plugin is written in [CoffeeScript](http://coffeescript.org/). Plain old [JS version](https://github.com/DenisGorbachev/visionary-pintask-plugin/blob/master/plugin.js) is available, too._

So easy to make your own plugin ;)
