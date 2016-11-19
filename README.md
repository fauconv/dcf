# Welcome to the Drupal Custom Factory Project version 0.1.0

This project is just a **SANDBOX** for the moment. **No stable version is provided yet**


## The goals are

* display datas from Drupal 8 with Angular 2 and ionic 2
* find a way for backend developers work with frontend developers in same time (frontend should dont have to wait data from backend to work)
* avoid problem of SEO with angular (not a full single page application)
* Give a standalone Distribution of Drupal 8 to develop with angular (composer, and nodejs are downloaded locally in the project, no global tool needed). Only PHP Cli and a web server (suggest Apache) are needed


## TODO

* add a script for crontab
* Install website with drupal console + add multi level node_modules (specific npm module should be installed in the site directory, and common npm module in the "web" directory)
* provide multi modes to use angular :
    * a drupal web-service + angular composant : node, taxo... (single page web-site) + drupal web page for SEO
    * a drupal theme like of angular generation (multi page web-site) with dynamic blocs
    * a drupal web-service +  ionic 2 (single page application)
    * a standard drupal web-site without angular
