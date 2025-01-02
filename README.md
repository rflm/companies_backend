# README

Backend Developer Homework Assignment

Screen recording of me coding the task: https://drive.google.com/file/d/17uYrDd3zO6T9WgyMjKHKhuuEr7J7_Y_i/view?usp=drive_link

Decision log:
- In the task requirements you requested to use ruby 3.3, but there was a 3.4 release recently, so I decided to go with this one
- I decided to use Alba gem for serialization. I like to keep  all API responses serialized, because it helps to prevent doing the breaking changes
- I put the logic for creating the single company in the `create` action inside the controller, because it's so small it wouldn't make sense to move it outside
- Import is all or nothing. It won't save any company from the csv if import fails. I think it wouldn't make sense to import some companies successfuly and skip other ones, also it's easier to compose the response in this case. Also, client doesn't need to remove imported companies from the csv before trying again.

It would be nice to add documentation and auth (maybe authorize client by API_KEY?) but you specified this task should take ~1 hour so I didn't do it
