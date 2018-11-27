PromoDJPaneView = require './promodj-pane-view'


{CompositeDisposable} = require 'atom'

module.exports = PromoDJPane =
  promoDJPaneView: null
  modalPanel: null
  subscriptions: null
  enlarged : false
  promoDJPane: null

  activate: (state) ->
    @promoDJPaneView = new PromoDJPaneView(state.promoDJPaneViewState)
    @modalPanel = atom.workspace.addRightPanel(item: @promoDJPaneView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'promodj-pane:toggle': => @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'promodj-pane:enlarge': => @enlarge()

    #Create the Youtube Webview
    webview = document.createElement("webview");
    webview.setAttribute("src", "http://www.promodj.com/music")
    webview.setAttribute("id", "promodj-pane")

    #Append it to the right panel
    @promoDJPane = document.getElementsByClassName("promodj")[0]
    @promoDJPane.appendChild(webview)

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @promoDJPaneView.destroy()

  serialize: ->
    promoDJPaneViewState: @promoDJPaneView.serialize()

  toggle: ->
    console.log 'PromoDJPane was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

  enlarge: ->
    console.log(@promoDJPane)

    if @enlarged == false
      #@promoDJPane.setAttribute('width', width * 2)
      #@promoDJPane.setAttribute('height', height * 2)
      @enlarged = true
    else
      #@promoDJPane.setAttribute('width', width / 2)
      #@promoDJPane.setAttribute('height', height / 2)
      @enlarged = false
