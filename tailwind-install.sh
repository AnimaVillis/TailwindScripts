#!/usr/bin/python3
import os

print("Tailwind Autoinstall with NPM");

print("Now i need to take some information from You");

ext = input("Files extension html/php?:");
pub = input("Will you use public folder for project? (y/n):");
check = input("Is Node.js - npm packages manager installed? (y/n):");
cssname = input("Write name of watching file like app.css to build your style.css:");
cssname_final = cssname.replace(".css", "")
scripts = input("Add build and watch scripts for Your tailwind?(y/n):");

index_generated = '<!DOCTYPE html>\n<html lang="pl">\n<head>\n<meta charset="UTF-8">\n<meta http-equiv="X-UA-Compatible" content="IE=edge">\n<meta name="viewport" content="width=device-width, initial-scale=1.0">\n<title>TailwindCSS - tailwind-forum.pl - Poradnik instalacji NPM</title>\n<link rel="stylesheet" href="style.css">\n</head>\n<body>\n<div class="flex justify-center">\n<h1 class="text-3xl text-blue-500">Cześć!</h1>\n<h1 class="text-2xl text-orange-500">Poradnik instalacji tailwindcss wraz z npm.</h1>\n</div>\n</body>\n</html>';

if check == 'n':
    os.system('apt install nodejs npm');

if pub == 'y':
    os.system('mkdir public');
    with open('public/index.'+ext, 'w') as indexfile:
        indexfile.write(index_generated);
else:
    with open('index.'+ext, 'w') as indexfile:
        indexfile.write(index_generated);



npminit = 'npm init -y';
npmtailwind = 'npm install -D tailwindcss@latest postcss@latest autoprefixer@latest';
#configgenerator = 'npx tailwindcss init --postcss';

with open(cssname_final+'.css', 'w') as css:
    css.write("@tailwind base;\n@tailwind components;\n@tailwind utilities;");

if pub == 'y':
    with open('tailwind.config.js', 'w') as twco:
        twco.write("module.exports = {\npurge: ['./public/**/*."+ext+"'],\ndarkMode: false, // or 'media' or 'class'\ntheme: {\nextend: {},\n},\nvariants: {\nextend: {},\n},\nplugins: [],\n};");
else:
    with open('tailwind.config.js', 'w') as twco:
        twco.write("module.exports = {\npurge: ['./**/*."+ext+"'],\ndarkMode: false, // or 'media' or 'class'\ntheme: {\nextend: {},\n},\nvariants: {\nextend: {},\n},\nplugins: [],\n};");

os.system(npminit);
os.system(npmtailwind);

if scripts == 'y' and pub == 'y':
    with open('package.json', 'r') as file:
        data = file.readlines();
    data[6] = '"build": "tailwindcss build '+cssname_final+'.css -o public/style.css",\n"watch": "tailwindcss build '+cssname_final+'.css -o public/style.css -w"';
    with open('package.json', 'w') as file:
        file.writelines(data);
else:
    with open('package.json', 'r') as file:
        data = file.readlines();
    data[6] = '"build": "tailwindcss build '+cssname_final+'.css -o style.css",\n"watch": "tailwindcss build '+cssname_final+'.css -o style.css -w"';
    with open('package.json', 'w') as file:
        file.writelines(data);

os.system('npm run build');
os.system('clear');

print('Thanks for using my script, all changed and updates are on my github:');
print('https://github.com/AnimaVillis');
print('Polish support forum for TailwindCSS - https://tailwind-forum.pl');