module PSS
  class Users
    def self.all
      sql = %q[SELECT * FROM users]
      result = PSS.db.exec sql
      result.entries
    end

    def self.find id
      sql = %q[SELECT * FROM users WHERE id = $1]
      result = PSS.db.exec sql, [id]
      result.first
    end

    def self.find_by_username username
      sql = %q[SELECT * FROM users WHERE username = $1]
      result = PSS.db.exec sql, [username]
      result.first
    end
  end
end
