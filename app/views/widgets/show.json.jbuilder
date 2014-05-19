json.id @widget.id if @widget.id
json.location @widget.location
json.temperature @widget.degrees_f.html_safe if @widget.degrees_f
json.json @widget.json if @widget.json