function  sendGmail(toAddress, subject, userId, password )
% sendGmail(toAddress, subject, userId, password) 
% sends email to toAddress from userId@gmail.com with password

setpref('Internet','E_mail', [userId '@gmail.com']);
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','SMTP_Username',[userId '@gmail.com']);
setpref('Internet','SMTP_Password',password);

% Gmail server.
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

%% Send the email


sendmail(toAddress,subject)

end

