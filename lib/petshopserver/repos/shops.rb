module PSS
  class Shops
    def self.all
      sql = %q[SELECT * FROM shops]
      result = PSS.db.exec sql
      result.entries
    end

    def self.find id
      sql = %q[SELECT * FROM shops WHERE id = $1]
      result = PSS.db.exec(sql, [id])
      result.first
    end
  end
end
