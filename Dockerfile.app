FROM mcr.microsoft.com/dotnet/sdk:6.0-bullseye-slim AS build

# Install Node 17
RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash - \
    && apt-get install -y nodejs

WORKDIR /source
COPY *.sln .
COPY DotnetTemplate.Web/. ./DotnetTemplate.Web

WORKDIR /source/DotnetTemplate.Web
RUN dotnet publish -c Release -o /app

# Final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app ./

EXPOSE 5000/tcp
ENTRYPOINT ["dotnet", "DotnetTemplate.Web.dll"]


#Create a new environment on Github
#Add secret on the environment
#Add the environment to the action step
#Set the environment variables from the secrets in the action step
#Pass the environment variables if needed to docker command
