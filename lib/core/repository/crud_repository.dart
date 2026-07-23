abstract class CrudRepository<T, ID> {
  /// Get all records
  Future<List<T>> getAll();

  /// Get single record
  Future<T> getById(ID id);

  /// Create new record
  Future<T> create(T item);

  /// Update existing record
  Future<T> update(ID id, T item);

  /// Delete record
  Future<void> delete(ID id);
}