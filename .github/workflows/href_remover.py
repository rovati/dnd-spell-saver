myfile = "../dnd_spell_saver/build/index.html"

with open(myfile, "r") as f:
    data = f.read()
    updatedData = data.replace("<base href=\"/\">", "")

with open(myfile, "w") as f:
    f.write(updatedData)