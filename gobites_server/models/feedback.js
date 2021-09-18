const db = require("../db");

class Feedback{
    constructor(){
        if(this.instance) return this.instance;
        Feedback.instance = this;
    }

    async getByRid(rid){
        const rows = await db.query(`SELECT * from feedback WHERE rid = ?`,[rid]); 
        return this.rowToArray(rows);
    }

    async getRatingByRid(rid){
        const rows = await db.query(`SELECT SUM(rating)/COUNT(*) as rating FROM feedback WHERE rid = ?`,[rid]); 
        return this.rowToArray(rows[0]);
    }

    rowToArray(sqlRows) {
        if (!sqlRows) return null;
        return JSON.parse(JSON.stringify(sqlRows));
      }
}

module.exports = new Feedback();