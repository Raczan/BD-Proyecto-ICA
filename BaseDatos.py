import pymysql
import time
class DataBase:
    def __init__(self):
        self.connection = pymysql.connect(
            host='bfhfjzo1sfttytwzxc3i-mysql.services.clever-cloud.com',
            user='ucyelmk2jljt3hbt',
            password='PGCkhjiLJEHtE2ARKEee',
            db='bfhfjzo1sfttytwzxc3i'
            )
        self.cursor = self.connection.cursor()
        print("Conexion exitosa")
        
    def close(self):
            self.connection.close()
            print("Conexion a la BD finalizada")
            
    def insert(self,cont,IGE,varCl):
        fecha = time.strftime("%Y-%m-%d")
        hora = time.strftime("%X")
        estacion=1
        sql= "INSERT INTO historial(SO2,NO2,PM,O3,CO,IGE,fecha,hora,estacion_idestacion,temp,pressure,humidity,wind) VALUES({},{},{},{},{},{},'{}','{}',{},{},{},{},{})".format(cont[0],cont[1],cont[2],cont[3],cont[4],IGE,fecha,hora,estacion,varCl[0],varCl[1],varCl[2],varCl[3])
        try:
            self.cursor.execute(sql)
            self.connection.commit()
            print("Datos insertados exitosamente")
        except Exception as e:
            raise
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                