FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["DockerizedApi/DockerizedApi.csproj", "DockerizedApi/"]
RUN dotnet restore "DockerizedApi/DockerizedApi.csproj"
COPY . .
WORKDIR "/src/DockerizedApi"
RUN dotnet publish "DockerizedApi.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "DockerizedApi.dll"]