#report updation on google sheet
#loading required packages
require(RMySQL)
require(tidyverse)
require(googlesheets4)
require(googledrive)

googledrive::drive_auth('uc.kheloyaar@gmail.com',cache = ".secrets")
googlesheets4::gs4_auth(token = drive_token())


while(T){
  

#games.db  credentials
user.games='u483816504_retention'
password.games='3txMtAZ?vJ'
database.name.games='u483816504_retention'

#bizz.db credentials
user.bizz='u483816504_retentionbiz'
password.bizz='6x=]4n]nkJ'
database.name.bizz='u483816504_retentionbiz'

#net.db credentials
user.net='u483816504_retentionnet'
password.net='dMc*jm5*8'
database.name.net='u483816504_retentionnet'

#club.db credentials
user.club='u483816504_retentionclub'
password.club='m|@ldYJ5#rW'
database.name.club='u483816504_retentionclub'

#pkr.db credentials
user.pkr='u483816504_retainpkr'
password.pkr='aNBugcT*w7*'
database.name.pkr='u483816504_retainpkr'

#logging into .games db
success=T
while(success){
  looping=T
  
  tryCatch(assign('con',value =dbConnect(MySQL(),user=user.games,password=password.games,dbname=database.name.games,host="srv1126.hstgr.io",port=3306),envir = .GlobalEnv ),error=function(e){
    
    Sys.sleep(6)
    print('error')
    assign('looping',FALSE,envir = .GlobalEnv)
    
  })
  
  if(looping){
    success=F
  }
  
}

success=T
while(success){
  looping=T
  
  tryCatch(assign('client.data.games',value =dbReadTable(con,"call_status_clients"),envir = .GlobalEnv ),error=function(e){
    
    Sys.sleep(6)
    print('error')
    assign('looping',FALSE,envir = .GlobalEnv)
    
  })
  
  if(looping){
    success=F
  }
  
}


dbDisconnect(con)

print('games.db is retrieved')

#logging into .bizz db
success=T
while(success){
  looping=T
  
  tryCatch(assign('con',value =dbConnect(MySQL(),user=user.bizz,password=password.bizz,dbname=database.name.bizz,host="srv1126.hstgr.io",port=3306),envir = .GlobalEnv ),error=function(e){
    
    Sys.sleep(6)
    print('error')
    assign('looping',FALSE,envir = .GlobalEnv)
    
  })
  
  if(looping){
    success=F
  }
  
}

success=T
while(success){
  looping=T
  
  tryCatch(assign('client.data.bizz',value =dbReadTable(con,"call_status_clients"),envir = .GlobalEnv ),error=function(e){
    
    Sys.sleep(6)
    print('error')
    assign('looping',FALSE,envir = .GlobalEnv)
    
  })
  
  if(looping){
    success=F
  }
  
}


dbDisconnect(con)
print('bizz.db is retained')

#logging into .club db

success=T
while(success){
  looping=T
  
  tryCatch(assign('con',value =dbConnect(MySQL(),user=user.club,password=password.club,dbname=database.name.club,host="srv1126.hstgr.io",port=3306),envir = .GlobalEnv ),error=function(e){
    
    Sys.sleep(6)
    print('error')
    assign('looping',FALSE,envir = .GlobalEnv)
    
  })
  
  if(looping){
    success=F
  }
  
}

success=T
while(success){
  looping=T
  
  tryCatch(assign('client.data.club',value =dbReadTable(con,"call_status_clients"),envir = .GlobalEnv ),error=function(e){
    
    Sys.sleep(6)
    print('error')
    assign('looping',FALSE,envir = .GlobalEnv)
    
  })
  
  if(looping){
    success=F
  }
  
}


dbDisconnect(con)
print('club data is retrieved')
#logging into .net db

success=T
while(success){
  looping=T
  
  tryCatch(assign('con',value =dbConnect(MySQL(),user=user.net,password=password.net,dbname=database.name.net,host="srv1126.hstgr.io",port=3306),envir = .GlobalEnv ),error=function(e){
    
    Sys.sleep(6)
    print('error')
    assign('looping',FALSE,envir = .GlobalEnv)
    
  })
  
  if(looping){
    success=F
  }
  
}

success=T
while(success){
  looping=T
  
  tryCatch(assign('client.data.net',value =dbReadTable(con,"call_status_clients"),envir = .GlobalEnv ),error=function(e){
    
    Sys.sleep(6)
    print('error')
    assign('looping',FALSE,envir = .GlobalEnv)
    
  })
  
  if(looping){
    success=F
  }
  
}


dbDisconnect(con)
print('net.db is retained')

#logging into .pkr db

success=T
while(success){
  looping=T
  
  tryCatch(assign('con',value =dbConnect(MySQL(),user=user.pkr,password=password.pkr,dbname=database.name.pkr,host="srv1126.hstgr.io",port=3306),envir = .GlobalEnv ),error=function(e){
    
    Sys.sleep(6)
    print('error')
    assign('looping',FALSE,envir = .GlobalEnv)
    
  })
  
  if(looping){
    success=F
  }
  
}

success=T
while(success){
  looping=T
  
  tryCatch(assign('client.data.pkr',value =dbReadTable(con,"call_status_clients"),envir = .GlobalEnv ),error=function(e){
    
    Sys.sleep(6)
    print('error')
    assign('looping',FALSE,envir = .GlobalEnv)
    
  })
  
  if(looping){
    success=F
  }
  
}


dbDisconnect(con)
print('pkr.db is retained')

total.databases<-ls()[grep("^client.data.",ls())]
sheets<-c('bizz','club','games','net')
for(i in 1:length(sheets)){
  data<-get(total.databases[i])
  #data<-data[data$Deposit_Amount>0,]
  data<-data[!is.na(data$Master),]
  data<-subset(data,data$Call_Date>=Sys.Date()-10)
  
  success=T
  while(success){
    looping=T
    
    tryCatch(range_write("1yVRrQ7vHz9bhO26cUpcCaHu9vlGYt0GAkoLs91Pc1ho",data = data,sheet = sheets[i],col_names = T,reformat = T),error=function(e){
      
      Sys.sleep(6)
      print('error')
      assign('looping',FALSE,envir = .GlobalEnv)
      
    })
    
    if(looping){
      success=F
    }
    
  }
  
  
}

Sys.sleep(10*60)

}

#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
