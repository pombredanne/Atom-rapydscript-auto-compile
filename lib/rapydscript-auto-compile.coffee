rapyd = require 'rapydscript'
fs = require('fs')

compile = () ->
    activeEditor = atom.workspace.getActiveEditor()

    if activeEditor
        filePath = activeEditor.getPath()

        if filePath.indexOf('.pyj') == filePath.length - 4
            # console.log(rapyd)
            text = activeEditor.getText()
            result = rapyd.minify(filePath, filePath.replace('.pyj', '.js'));


            filenamePath = filePath.replace('.pyj', '.js')
            fs.writeFile(filenamePath, result.code, (err) ->
                if err
                    console.log("Failed to compile rapydscript file!")
            )

module.exports =
    activate: (state) ->
        atom.workspaceView.command "rapydscript:compile", => compile()
        atom.workspaceView.command "core:save", => compile()
