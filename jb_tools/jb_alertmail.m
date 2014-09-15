function jb_alertmail(message)
    if ~exist('message','var'); message = ''; end
    
    mail = 'user@gmail.com';
    password = 'password';
    setpref('Internet','SMTP_Server','smtp.gmail.com');
    setpref('Internet','E_mail',mail);
    setpref('Internet','SMTP_Username',mail);
    setpref('Internet','SMTP_Password',password);
    props = java.lang.System.getProperties;
    props.setProperty('mail.smtp.auth','true');
    props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
    props.setProperty('mail.smtp.socketFactory.port','465');
    sendmail(mail,['[jan][participants] fmrisubway:',message])
end
