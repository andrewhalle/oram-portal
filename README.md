# oram-portal
ORAM Refugee Portal

[![Code Climate](https://codeclimate.com/github/andrewhalle/oram-portal/badges/gpa.svg)](https://codeclimate.com/github/andrewhalle/oram-portal)
[![Build Status](https://travis-ci.org/andrewhalle/oram-portal.svg?branch=master)](https://travis-ci.org/andrewhalle/oram-portal)
[![Test Coverage](https://codeclimate.com/github/andrewhalle/oram-portal/badges/coverage.svg)](https://codeclimate.com/github/andrewhalle/oram-portal/coverage)   
http://oram-portal2.herokuapp.com/

https://www.pivotaltracker.com/n/projects/2069417

ORAM (http://oramrefugee.org/) is an international non-profit organization dedicated to protecting the world's most vulnerable refugees. We seek to create a multi-language registration system allowing LGBTI refugees worldwide to enter information and upload documents on a secure platform that will save time and increase accuracy.

## Getting Started
Several features for this project require more setup than the usual "clone, bundle install..." process. First you must set the environment variable `form_key` in your local environment. This is a long string used for encrypting form data. We generated strings using [random.org](https://www.random.org). An example of a string which you can use for development is `iDEDgbGZr0nVHshYs8jK0TnJpWo2fOSyhZlQdmtCHJv2eXXFVlZlGiAGbA2h5CKdM4DTfyBbh8BuFhCn` (but a key that has never been published anywhere should be used for production).

E-mail sending features won't work until you set up a [SENDGRID](https://sendgrid.com/) account. The environment variables `SENDGRID_USERNAME` and `SENDGRID_PASSWORD` need to be set up in the deployment environment (like Heroku). Sending e-mails won't work from the local environment (like c9).

Explicitly, to clone this repo and get it running in a blank c9 instance (per the instructions on the course site), the commands we run are
```
curl -fsSL c9setup.saasbook.info | bash --login && rvm use 2.3.0 --default
sudo apt update
sudo apt install pdftk
git clone https://github.com/andrewhalle/oram-portal.git
cd oram-portal
gem install bundler
bundle install
export form_key=iDEDgbGZr0nVHshYs8jK0TnJpWo2fOSyhZlQdmtCHJv2eXXFVlZlGiAGbA2h5CKdM4DTfyBbh8BuFhCn
rails s -p $PORT -b $IP
rake cucumber
rake spec
```
------

Notes from Spring 2017 Team:
Phases (represented in :phase in :users) : [Phase I: Applicant Vetting, Phase II: ORAM Preparing
Client Case”, Phase III: Case Submitted, Phase IV: UNHCR Interview Completed,
Phase V: Recognized Refugee or Case rejected by UNHCR, Phase VI: Referred for
Resettlement or Appeal, Phase VII: Resettled or Case Closed]

Forms (represented in :form_type in :forms) : [ Form 2: Referral, Form 3: Client Questionnaire]

User Roles (represented in :role in :users) : [role 0: referrer, role 1: client]

### Notes
* phantomjs installation is required for testing with cucumber and rspec
* form_key: iDEDgbGZr0nVHshYs8jK0TnJpWo2fOSyhZlQdmtCHJv2eXXFVlZlGiAGbA2h5CKdM4DTfyBbh8BuFhCn

To use railroady gem:
For mac user install graphviz:
brew install graphviz

For ubuntu users
sudo apt-get install graphviz

run the command below to generate svg files
rake diagram:all
