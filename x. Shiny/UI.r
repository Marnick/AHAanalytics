library(shiny)

# Prepare some variables for the first run
update_no <<- 0;
save_to_file <<- 0;
text_in_box <<- "";
next_button<<-0;
last_button<<-0;
updatedcheckbox <<-0;

#Convert the data into something usefull
elements <<- 1:min(15,length(header[,3]));
checkboxes <<- 1:length(header[,3]);  names(checkboxes)  <<- paste0(substring(header[,1],1,15),"...");
radiobuttons <<- elements; names(radiobuttons) <<- matrix("-",elements[length(elements)]);

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel(
    h2(paste0("Dataset: ", colnames(header)[1])),
       h4("Dataset tool AHA (c) Bearingpoint 2014")),
  
  # Sidebar with a slider input for the number of bins
    sidebarPanel
    (
      
      textInput("text",value = "New name",label=NULL),div(),
      actionButton("Update_Name", label = "Update name"), actionButton("save_to_file", label = "Save to file"),br(),
      actionButton("close", label = "Close"),br(),br(),
      actionButton("vorige_x", label = "Last 15"),actionButton("volgende_x", label = "Next 15"),br(),
    
      fluidRow(
      column(2,radioButtons("radiobutton", label = "",choices=radiobuttons,selected="4")),
          
      column(10,checkboxGroupInput("Checkbox", label = "",
              choices = checkboxes[elements],selected = as.character(elements[1]-1+which(header[elements,3]==1))),
             textOutput("value")
      ))),
    
    # Show a plot of the generated distribution
    mainPanel( 
      plotOutput("piechart"),
                
      fluidRow(
      column(6,h5("Aantal elementen"),tableOutput("tableout")),
      column(6,h5("50 eerste waarden"),tableOutput("tableout2"))
      ))
))