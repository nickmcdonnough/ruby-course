module PSS
  class Pets
    def self.all kind
      sql = %Q[SELECT * FROM #{kind}]
      result = PSS.db.exec sql
      result.entries.each { |c| PSS.typecast c, 'adopted' }
    end

    def self.find_by_shop_id shopid, kind: nil
      sql = %Q[SELECT * FROM #{kind} WHERE "shopId" = $1]
      result = PSS.db.exec sql, [shopid]
      result.entries.each { |c| PSS.typecast c, 'adopted' }
    end

    def self.adopted_by userid, kind: nil
      sql = %Q[SELECT * FROM #{kind} WHERE adopted_by = $1]
      result = PSS.db.exec sql, [userid]
      result.entries.each { |c| PSS.typecast c, 'adopted' }
    end

    def self.update_status pet_id, user_id, kind: nil
      sql = %Q[
        UPDATE #{kind}
        SET adopted_by = $1,
        adopted = true
        WHERE id = $2
      ]
      PSS.db.exec sql, [user_id, pet_id]
      true
    end
  end
end
