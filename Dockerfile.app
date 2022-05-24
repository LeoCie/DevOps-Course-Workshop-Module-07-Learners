FROM mcr.microsoft.com/dotnet/sdk:6.0-bullseye-slim

# Install Node 17
RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash - \
    && apt-get install -y nodejs

WORKDIR /DotnetTemplate.Web
COPY ./DotnetTemplate.Web .
RUN dotnet restore

RUN npm install && npm run build

RUN dotnet publish -c Release -o out

EXPOSE 5000/tcp
ENTRYPOINT ["dotnet", "out/DotnetTemplate.Web.dll"]


#Create a new environment on Github
#Add secret on the environment 
#Add the environment to the action step
#Set the environment variables from the secrets in the action step
#Pass the environment variables if needed to docker command