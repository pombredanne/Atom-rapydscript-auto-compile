{WorkspaceView} = require 'atom'
RapydscriptAutoCompile = require '../lib/rapydscript-auto-compile'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "RapydscriptAutoCompile", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('rapydscript-auto-compile')

  describe "when the rapydscript-auto-compile:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.rapydscript-auto-compile')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'rapydscript-auto-compile:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.rapydscript-auto-compile')).toExist()
        atom.workspaceView.trigger 'rapydscript-auto-compile:toggle'
        expect(atom.workspaceView.find('.rapydscript-auto-compile')).not.toExist()
