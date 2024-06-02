package incrementos;
public class VerificarPagoResponse {

    enum TargetStatus{
        VALIDA,
        INVALIDA;
    }

    private TargetStatus status;
    public VerificarPagoResponse(TargetStatus status) {
        this.status = status;
    }

    public TargetStatus getStatus() {
        return status;
    }

}
