import os
import pyjson5 as json

replacements = {
    "Trading Card": "Card",
    "Card": "Baseball Card"
}

for root, dirs, files in os.walk("en", topdown=False):
    for name in files:
        filename = os.path.join(root, name)
        print(filename)
        data = json.load(open(filename))
        #print(data)
        for key in data:
            #print(data[key])
            if isinstance(data[key], str) and ("card" in data[key].lower()):
                for k in replacements:
                
                    if k in data[key]:
                        data[key] = data[key].replace(k, replacements[k])
                    if k.lower() in data[key]:
                        data[key] = data[key].replace(k.lower(), replacements[k].lower())
                    if k.upper() in data[key]:
                        data[key] = data[key].replace(k.upper(), replacements[k].upper())
                print(data[key])
        with open(filename, "wb") as outfile:
            json.dump(data, outfile)