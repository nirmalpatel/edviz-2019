#' make_plot() creates an interactive visualization of Distribution of Cronbach's Alpha when an item within an assessment is dropped.
#' Below are the arguments of the function
#' 
#' @param item_response_data A tibble or data.frame that contains data for item responses by students. The data should contain 4 variables: 'Student' (unique identifier for students), 'Assessment' (unique identifier for assessments), 'Question' (unique identifier for questions within an assessment) and 'UserScore' (dichotomous response).
#' 
#' @return A plotly object that can be viewed or saved as standalone HTML with `htmlwidgets::saveWidget()`.
make_interactive_plot <- function(df){
  
  require(tidyverse)
  require(psych)
  require(ltm)
  require(plotly)
  
  cronbach_df <- data.frame(Assessment = NA, Question = NA,
                            CronbachAlpha = NA, CronbachAlphaItemDrop = NA)
  
  assessments <- unique(df$Assessment)
  
  for(i in 1:length(assessments)){
    xyz_df <- df %>% 
      dplyr::filter(Assessment %in% assessments[i]) %>% 
      dplyr::select(Student, Question, UserScore) %>% 
      tidyr::spread(Question, UserScore) %>% 
      dplyr::select(-Student)
    
    result = tryCatch({
      psych::alpha(xyz_df, check.keys=TRUE)
    }, error = function(e) {
      "Error generated"
    })
    
    if(result != "Error generated"){
      coeff_df <- data.frame(result$alpha.drop) %>% 
        tibble::rownames_to_column("Question") %>% 
        dplyr::select(Question, std.alpha) %>% 
        dplyr::mutate(Question = str_replace(Question, '\\-$', '')) %>% 
        dplyr::rename(CronbachAlphaItemDrop = std.alpha) %>% 
        dplyr::mutate(CronbachAlpha = result$total$std.alpha,
                      Assessment = assessments[i])
      
      cronbach_df <- cronbach_df %>% 
        dplyr::bind_rows(coeff_df) 
    }
  }
  
  p <- cronbach_df %>% 
    drop_na() %>% 
    dplyr::mutate(CronbachAlpha = round(CronbachAlpha, digits = 2),
                  CronbachAlphaItemDrop = round(CronbachAlphaItemDrop, digits = 2)) %>% 
    mutate(line_alpha = CronbachAlphaItemDrop) %>% 
    ggplot(aes(fct_reorder(Assessment, -CronbachAlpha, sum)))+
    geom_line(aes(y = line_alpha, group = Assessment), linetype = 2, alpha = .75)+
    geom_point(alpha = .75, aes(y = CronbachAlphaItemDrop, color = '#000000', text = paste0("CronbachAlpha: ", CronbachAlpha,
                                                                                            "<br>CronbachAlphaItemDrop: ", CronbachAlphaItemDrop,
                                                                                            "<br>Question: ", Question,
                                                                                            "<br>Assessment ", Assessment)))+
    geom_point(aes(y = CronbachAlpha, color = '#0570b0', text = paste0("CronbachAlpha: ", CronbachAlpha,
                                                                       "<br>Assessment ", Assessment)))+
    geom_hline(yintercept = .7, color = '#b30000')+
    annotate("text", x = 10, y = .72, label = "Th = 0.70", color = '#b30000')+
    labs(x = 'Assessment',
         y = "Cronbach's alpha",
         title = "Distribution of Cronbach's alpha when an item is dropped")+
    scale_colour_manual(name = 'Cronbach alpha\nwhen an item is',
                        values =c('#0570b0'='blue', '#000000'='black'), labels = c('not dropped', 'dropped'))+
    theme_bw()+
    theme(axis.text.x = element_text(angle = 50, hjust = 1, size = 6),
          axis.text.y = element_text(size = 8),
          axis.title = element_text(size = 14, face = "bold"),
          plot.title = element_text(size = 16), legend.title = element_text(size = 14),
          legend.position = 'none')
  
  plotly::ggplotly(p, tooltip = "text")
}