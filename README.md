# 📚 Form - A Calisthenics workout tracker that records videos of your form.

Form is a calisthenics workout tracker that allows you to record video your exercises, store them as part of your workout log and compare to your your past performance. 

_DROP SCREENSHOT HERE_
<br>
App home: https://www.form-calsithennics.com
   

## Getting Started
### Setup

Install gems
```
bundle install
```

### ENV Variables
Create `.env` file
```
touch .env
```
Inside `.env`, set these variables. For any APIs, see group Slack channel.
```
CLOUDINARY_URL=your_own_cloudinary_url_key
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### Run a server
```
rails s
```

## Built With
- [Rails 7](https://guides.rubyonrails.org/) - Backend / Front-end
- [Stimulus JS](https://stimulus.hotwired.dev/) - Front-end JS
- [Heroku](https://heroku.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling
- [Figma](https://www.figma.com) — Prototyping

## Acknowledgements
Inspired by many calisthenics content creators I have been following over the years

## Team Members
- [Nicholas Matsumoto](https://www.linkedin.com/in/nicholas-matsumoto-18596a7b/)
- Chaewan Shin
- Ryo 

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
This project is licensed under the MIT License
