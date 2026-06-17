FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY ["BillingERP.Web.csproj", "."]
RUN dotnet restore "./BillingERP.Web.csproj"
COPY . .
RUN dotnet publish "BillingERP.Web.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "BillingERP.Web.dll"]