using Demo_ADO_Game.Models;
using Microsoft.Data.SqlClient;
using System.Data;


// Connection string pour se connecter à la DB
// https://www.connectionstrings.com/microsoft-data-sqlclient/
string connectionString = "Server=Forma200\\TFTIC;Database=GameDB;User Id=GameUser;Password=Test1234=;Trust Server Certificate=Yes;";

#region Introduction
SqlConnection connection = new SqlConnection(connectionString);

Console.WriteLine("Ouverture de la connexion vers SQL Server");
connection.Open();
Console.WriteLine($"État de la connexion : {connection.State}");
Console.WriteLine();


Console.WriteLine("Fermeture de la connexion vers SQL Server");
connection.Close();
Console.WriteLine($"État de la connexion : {connection.State}");
Console.WriteLine();
Console.WriteLine();
#endregion


#region Récuperation de données
// Récuperation du nombre de jeux
using (SqlConnection c  = new SqlConnection(connectionString))
{
    using(SqlCommand cmd = c.CreateCommand())
    {
        // Commande SQL
        cmd.CommandText = "SELECT COUNT(*) FROM Game;";
        cmd.CommandType = CommandType.Text;

        // Ouvrir la connexion vers la base de donnée
        c.Open();

        // Execution de la commande
        int nbGame = (int)cmd.ExecuteScalar();

        Console.WriteLine($"Il y a {nbGame} jeux dans la DB !");
    }

    // Fermeture de la connexion à la sorti du bloc "using"
}
Console.WriteLine();

// Récuperation de la liste des jeux
List<Game> games = new List<Game>();

using(SqlConnection c = new SqlConnection( connectionString))
{
    using(SqlCommand cmd = c.CreateCommand())
    {
        // Command SQL
        cmd.CommandText = "SELECT * FROM Game";
        cmd.CommandType = CommandType.Text;

        // Ouverture de la connexion SQL
        c.Open();
        
        // Execution de la requete a travers un Reader
        using(SqlDataReader reader = cmd.ExecuteReader())
        {
            while(reader.Read())
            {
                // Mapping => Transfere des données de la DB (IDataRecord) vers l'objet de notre model
                Game game = new Game
                {
                    Id = (int)reader["Id"],
                    Name = (string)reader["Name"],
                    Description = (reader["Description"] is DBNull) ? null : (string)reader["Description"],
                    ReleaseDate = (reader["ReleaseDate"] is DBNull) ? null : (DateTime)reader["ReleaseDate"],
                    StudioId = (int)reader["StudioId"]
                };

                // Ajout de l'element mappé dans la liste
                games.Add(game);
            }
        }
    }
}

Console.WriteLine("Liste des jeux : ");
foreach (Game game in games)
{
    Console.WriteLine($" - ({game.Id}) {game.Name} {game.ReleaseDate}");
}

#endregion