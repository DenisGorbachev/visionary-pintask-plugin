#share.plugins.visionary = {}

insertLink = ->
  $getCodeLink = $("<div class='expand-collapse-all-cards icon-list' title='Expand or collapse all cards in this list'></div>").on("click", share.run)
  $listHeaderQuickIcons = $(@find(".board-list-header .quick-icons"))
  $listHeaderQuickIcons.prepend($getCodeLink)

Template.listHeader.rendered = _.compose(insertLink, Template.listHeader.rendered)

Template.listHeader.events
  "click .expand-collapse-all-cards": (event, template) ->
    firstCard = Cards.findOne({listId: template.data._id}, {sort: {position: 1}})
    if !firstCard
      return
    shouldOpen = !Session.get("cardIsOpen:"+firstCard._id)
    Cards.find({listId: template.data._id}).forEach (card) ->
      Session.set("cardIsOpen:"+card._id, shouldOpen)
