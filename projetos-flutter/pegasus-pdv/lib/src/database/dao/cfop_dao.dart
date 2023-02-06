/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [CFOP] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************/
import 'package:drift/drift.dart';

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

part 'cfop_dao.g.dart';

@DriftAccessor(tables: [
          Cfops,
		])
class CfopDao extends DatabaseAccessor<AppDatabase> with _$CfopDaoMixin {
  final AppDatabase db;

  CfopDao(this.db) : super(db);

  Future<List<Cfop>?> consultarLista() => select(cfops).get();

  Future<List<Cfop>?> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM CFOP WHERE $campo like '%$valor%'", 
                                readsFrom: { cfops }).map((row) {
                                  return Cfop.fromData(row.data);  
                                }).get());
  }

  Future<Cfop?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM CFOP WHERE $campo = '$valor'", 
                                readsFrom: { cfops }).map((row) {
                                  return Cfop.fromData(row.data);  
                                }).getSingleOrNull());
  }  
  
  Stream<List<Cfop>> observarLista() => select(cfops).watch();

  Future<Cfop?> consultarObjeto(int pId) {
    return (select(cfops)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> ultimoId() async {
    final resultado = await customSelect("select MAX(ID) as ULTIMO from CFOP").getSingleOrNull();
    return resultado?.data["ULTIMO"] ?? 0;
  } 

  Future<int> inserir(Cfop pObjeto) {
    return transaction(() async {
      final maxId = await ultimoId();
      pObjeto = pObjeto.copyWith(id: maxId + 1);
      final idInserido = await into(cfops).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Cfop pObjeto) {
    return transaction(() async {
      return update(cfops).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Cfop pObjeto) {
    return transaction(() async {
      return delete(cfops).delete(pObjeto);
    });    
  }

  
}