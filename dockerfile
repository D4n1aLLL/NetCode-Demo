#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0.15-focal as base

#COPY ["./dotMemory/", "/app/"]
#RUN apt-get update && apt-get install -y libc6-dev && apt-get install -y libgdiplus
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:5.0.406-focal AS build
WORKDIR /src
COPY ["ConsoleApp2/ConsoleApp2.csproj", "ConsoleApp2/"]
RUN dotnet restore "ConsoleApp2/ConsoleApp2.csproj"
COPY . .
WORKDIR "/src/ConsoleApp2"
RUN dotnet build "ConsoleApp2.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ConsoleApp2.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ConsoleApp2.dll"]