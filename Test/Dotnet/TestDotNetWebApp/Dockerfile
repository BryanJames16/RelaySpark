# Builder Image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS builder

WORKDIR /src

COPY . .

RUN dotnet publish ./TestDotNetWebApp.csproj --output ./publish --verbosity normal


# Main Image
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine3.21-amd64 AS app

WORKDIR /src

COPY --from=builder /src/publish .

EXPOSE 8080

ENTRYPOINT ["dotnet" , "TestDotNetWebApp.dll"]
