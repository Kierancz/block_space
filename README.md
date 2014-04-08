== README

Project Title: Story Blocks

Team Members: Derek Baumgartner, Kieran Czerwinski, and Yongqiang Shen

Description:
This is the final group project app for CSCI 3308. 

The project aims to allow users to take content from the Internet such as text,
pictures, and video and create blocks out of the content that can be stacked to
create a mixed-media story. These blocks will take HTML code as input and execute 
the code upon viewing. They will be able to be linked together to form a user story 
that can be shared with others. The user could also invite other users to 
collaborate on building a story. The ability to collaborate with others, take any 
HTML input, and the informality of the service differentiates it from things like 
blogs.

Models:
User:
- Attributes
Username String
ID Integer
Password Hash
Email Address String
Friends?
- Relationships
has_and_belongs_to_many relationship with Stories

Story:
- Attributes
Title
Description
Collaborating users
- Relationships
has_and_belongs_to_many relationship with Users
has_many relationship with Blocks

Block:
- Attributes
Parent Story
Block number
HTML content
-Relationships
belongs_to relationship with Stories

